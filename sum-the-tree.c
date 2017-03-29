struct node
{
  int value;
  struct node* left;
  struct node* right;
};


int sumTheTreeValues(struct node* root)
{
  if (!root) return 0;
  return root->value + sumTheTreeValues(root->left) + sumTheTreeValues(root->right);
}
